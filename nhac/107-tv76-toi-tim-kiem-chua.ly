% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Tôi Tìm Kiếm Chúa" }
  composer = "Tv. 76"
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
  \autoPageBreaksOff
  \partial 4 \tuplet 3/2 { g8 d bf' } |
  bf4 \tuplet 3/2 { a8 g d' } |
  d4 r8 ef16 d |
  c8 c c c |
  c c4 d8 |
  bf4 r8 bf16 bf |
  c8 d c c |
  bf g4 bf8 |
  a2 ~ |
  a4 fs16 (g) a8 |
  d,4. bf'8 |
  a bf4 c8 |
  d4 d16 (ef) d8 |
  c4. c8 |
  d bf4 a8 |
  g2 ~ |
  g4 \bar "||" \break
  
  f!?8 f |
  g4 \tuplet 3/2 { g8 d d } |
  bf'4. a16 c |
  d4 \tuplet 3/2 { d8 bf a } |
  g2 ~ |
  g4 g8 ef |
  
  \pageBreak
  
  d4 \tuplet 3/2 { g8 fs g } |
  a4. a16 c |
  d4 \tuplet 3/2 { d,8 bf' a } |
  g2 ~ |
  g4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  \tuplet 3/2 { g8 d bf' } |
  bf4 \tuplet 3/2 { a8 g d' } |
  d4 r8 c16 bf |
  a8 a a a |
  a a4 fs8 |
  g4 r8 g16 g |
  a8 bf a a |
  g ef4 g8 |
  d2 ~ |
  d4 fs16 (g) a8 |
  d,4. g8 |
  fs g4 a8 |
  bf4 bf16 (c) bf8 |
  a4. a8 |
  bf g4 fs8 |
  g2 ~ |
  g4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Trong ngài khốn quẫn, tôi tìm kiếm Chúa,
  suốt đêm thâu tay tôi vươn lên không biết mỏi,
  và hồn tôi đâu thiết chi những lời ủi an.
  Tưởng nhớ Ngài, tôi thở than rên xiết,
  gẫm suy liên nên khí lực suy tàn.
  \stanzaReminderOn
  <<
    {
      \set stanza = "1."
      Ngài làm con không hề chợp mắt,
      lòng xao xuyến nói chẳng nên lời,
      Nhớ tưởng hoài bao ngày xa cũ,
      Hồn e ấp từng tháng năm qua.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngồi tàn canh nghe lòng thầm thì,
	    và tâm trí cứ tự hỏi hoài:
	    Có phải Ngài xua từ luôn mãi
	    Và muôn kiếp đành dứt yêu thương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Tình Ngài yêu nay rồi cạn mãi,
	    lời minh ước dứt bỏ muôn đời,
	    Chúa giận hờn quên lòng thương xót
	    Và phong kín tình mến bao la.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Lòng quặn đau bao lần thầm nghĩ:
	    rầy Thiên Chúa hết ra tay rồi,
	    Những công trình xưa Ngài thi thố
	    Lòng con vẫn hằng gẫm suy luôn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Thần nào đâu cao trọng bằng Chúa,
	    lạy Thiên Chúa thánh thiêng muôn trùng,
	    Đã thể hiện bao kỳ công đó,
	    Ngàn dân nước từng thấy uy phong.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ngài hiển linh mây tầng vọng tiếng,
	    đổ mưa xuống khắp nẻo tuôn tràn,
	    Nước trở mình rung động kinh khiếp,
	    Vực sâu cũng sợ hãi run lên.
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
  %page-count = #1
  system-system-spacing = #'((basic-distance . 0.1) (padding . 2.5))
  ragged-bottom = ##t
}

TongNhip = {
  \key bf \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
