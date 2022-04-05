% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Con Nâng Hồn Lên Tới Chúa" }
  composer = "Tv. 24"
  tagline = ##f
}

% mã nguồn cho những chức năng chưa hỗ trợ trong phiên bản lilypond hiện tại
% cung cấp bởi cộng đồng lilypond khi gửi email đến lilypond-user@gnu.org
% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

% in số phiên khúc trên mỗi dòng
#(define (add-grob-definition grob-name grob-entry)
     (set! all-grob-descriptions
           (cons ((@@ (lily) completize-grob-entry)
                  (cons grob-name grob-entry))
                 all-grob-descriptions)))

#(add-grob-definition
    'StanzaNumberSpanner
    `((direction . ,LEFT)
      (font-series . bold)
      (padding . 1.0)
      (side-axis . ,X)
      (stencil . ,ly:text-interface::print)
      (X-offset . ,ly:side-position-interface::x-aligned-side)
      (Y-extent . ,grob::always-Y-extent-from-stencil)
      (meta . ((class . Spanner)
               (interfaces . (font-interface
                              side-position-interface
                              stanza-number-interface
                              text-interface))))))

\layout {
    \context {
      \Global
      \grobdescriptions #all-grob-descriptions
    }
    \context {
      \Score
      \remove Stanza_number_align_engraver
      \consists
        #(lambda (context)
           (let ((texts '())
                 (syllables '()))
             (make-engraver
              (acknowledgers
               ((stanza-number-interface engraver grob source-engraver)
                  (set! texts (cons grob texts)))
               ((lyric-syllable-interface engraver grob source-engraver)
                  (set! syllables (cons grob syllables))))
              ((stop-translation-timestep engraver)
                 (for-each
                  (lambda (text)
                    (for-each
                     (lambda (syllable)
                       (ly:pointer-group-interface::add-grob
                        text
                        'side-support-elements
                        syllable))
                     syllables))
                  texts)
                 (set! syllables '())))))
    }
    \context {
      \Lyrics
      \remove Stanza_number_engraver
      \consists
        #(lambda (context)
           (let ((text #f)
                 (last-stanza #f))
             (make-engraver
              ((process-music engraver)
                 (let ((stanza (ly:context-property context 'stanza #f)))
                   (if (and stanza (not (equal? stanza last-stanza)))
                       (let ((column (ly:context-property context
'currentCommandColumn)))
                         (set! last-stanza stanza)
                         (if text
                             (ly:spanner-set-bound! text RIGHT column))
                         (set! text (ly:engraver-make-grob engraver
'StanzaNumberSpanner '()))
                         (ly:grob-set-property! text 'text stanza)
                         (ly:spanner-set-bound! text LEFT column)))))
              ((finalize engraver)
                 (if text
                     (let ((column (ly:context-property context
'currentCommandColumn)))
                       (ly:spanner-set-bound! text RIGHT column)))))))
      \override StanzaNumberSpanner.horizon-padding = 10000
    }
}

stanzaReminderOff =
  \temporary \override StanzaNumberSpanner.after-line-breaking =
     #(lambda (grob)
        ;; Can be replaced with (not (first-broken-spanner? grob)) in 2.23.
        (if (let ((siblings (ly:spanner-broken-into (ly:grob-original grob))))
              (and (pair? siblings)
                   (not (eq? grob (car siblings)))))
            (ly:grob-suicide! grob)))

stanzaReminderOn = \undo \stanzaReminderOff
% kết thúc mã nguồn

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 4 a8. a16 |
  e8 a4 b8 |
  c4. b8 |
  e4 d8. d16 |
  d8 c ([d]) c |
  b2 ~ |
  b4 a8. g!?16 |
  g8 a4 b8 |
  \slashedGrace { d,16 ( } e4) r8 c' |
  c d b8. b16 |
  f'8 e4 e,8 |
  c'8. [b16] b8 [a] ~ |
  a2 \bar "||"
  
  \slashedGrace { e16 _( } a8.) [f16] e8 b |
  \slashedGrace { e16 (f } e4.) e16 e |
  f8 c16 (e) a8 c |
  b2 ~ |
  b4 c8. g16 |
  a8 a d c16 (d) |
  e4. e16 c |
  c8 e c16 (b) g8 |
  a2 ~ |
  a4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  a8. a16 |
  e8 a4 gs8 |
  a4. a8 |
  gs4 b8. b16 |
  b8 a ([b]) a |
  e2 ~ |
  e4 a8. g!?16 |
  g8 a4 b8 |
  \slashedGrace { d,16 ( } e4) r8 a |
  a b gs8. gs16 |
  a8 e4 e8 |
  a8. <a d,>16 <gs e>8 c, ~ |
  c2
  \hide R2*9
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Con nâng hồn lên tới Chúa, lạy Chúa,
  con luôn tin tưởng nơi Ngài.
  Xin đừng để con xấu hổ,
  đừng để quân thù nhạo báng con,
  lạy Chúa con tôn thờ.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Chẳng ai trông cậy Chúa
      mà lại phải nhục nhã hổ ngươi,
      Chỉ người nào tự dưng phản phúc
      mới nhục nhằn xấu hổ mà thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chỉ cho con đường Chúa
	    và tỏ lối Ngài con dõi theo.
	    Khấn nguyện Ngài bảo ban dạy dỗ,
	    dẫn hồn này bước theo đường ngay.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Sớm hôm trông cậy Chúa,
	    Ngài từ ái và luôn cứu nguy.
	    Cúi lạy Ngài đừng quên tình nghĩa
	    đã biểu lộ mãi tự ngàn xưa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Tuổi xuân bao lầm lỗi,
	    trông mong Chúa đừng ghi nhớ chi,
	    Hãy biểu lộ tình thương của Chúa
	    đoái nhìn và xót thương mà thôi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Những ai tôn sợ Chúa
	    được Ngài chỉ dậy cho lối đi,
	    Sẽ một đời mừng vui hạnh phúc,
	    tới hậu duệ vẫn hưởng lộc ân.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Mắt con trông về Chúa,
	    kìa dò lưới bủa giăng khắp nơi,
	    Chúa nhìn lại và thương giải cứu
	    chút phận này khốn khổ lẻ loi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Náu thân bên lòng Chúa,
	    Ngài đừng nỡ để con hổ ngươi,
	    Hãy bảo toàn và thương giải thoát
	    kẻ một niềm mến yêu cậy trông.
    }
  >>
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  page-count = #1
}

TongNhip = {
  \key c \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    \override Lyrics.LyricSpace.minimum-distance = #0.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
