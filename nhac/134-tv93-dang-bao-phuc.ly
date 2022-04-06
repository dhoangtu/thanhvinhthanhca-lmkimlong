% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Đấng Báo Phục" }
  composer = "Tv. 93"
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
nhacPhienKhucSop = \relative c' {
  \partial 8 d8 |
  bf4. d16 ef |
  c4 r8 c |
  g'4. g16 g |
  f8 a c bf |
  bf2 |
  d8. d16 a8 a |
  bf4. bf16 c |
  f,4 \tuplet 3/2 { ef8 bf' g } |
  f8. g16 \tuplet 3/2 { ef8 c f } |
  bf,4 \bar "||" \break
  
  d8 c |
  bf4 bf8 ef ~ |
  ef4 ef8 d |
  c4 g'8 f ~ |
  f bf bf bf |
  a2 ~ |
  a4 bf8 g |
  f4 d'8 d ~ |
  d c c d |
  g,4 g8 a |
  g f4 c'8 |
  bf2 ~ |
  bf4 r8 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*9
  r4
  d8 c |
  bf4 bf8 ef ~ |
  ef4 ef8 d |
  c4 g'8 f ~ |
  f ef d d |
  f2 ~ |
  f4 g8 ef |
  d4 bf'8 bf ~ |
  bf a a f |
  e!4 e8 f |
  c d4 ef8 |
  d2 ~ |
  d4 r8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Chúa là Đấng báo phục,
      lạy Chúa Đấng báo phục xin hãy quang lâm.
      Đấng xét xử trần gian xin đứng dậy
      Trả lũ kiêu căng xứng công việc chúng làm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Dân tộc Chúa kén chọn bị chúng áp bức
	    và uy hiếp khôn ngơi,
	    chúng giết sạch kiều cư trên đất này,
	    Tàn sát cô nhi, bách hại người góa bụa.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúng rằng: Chúa thấy gì,
	    này lũ dốt nát và ngu ngốc kia ơi,
	    Đấng gắn liền vành tai,
	    vo mắt tròn lại chẳng nghe chi,
	    lẽ đâu chẳng thấy gì.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Con người tính toán gì là Chúa biết rõ
	    tựa cơn gió bay qua.
	    Diễm phúc kẻ thành tâm nghe Chúa
	    dậy được sống an vui dẫu trong ngày mắc nạn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúa nào có khước từ,
	    ruồng rẫy dân riêng Ngài luôn mãi yêu thương,
	    Pháp lý sẽ trở lui nơi pháp đình,
	    vạn kiếp an vui đến cho người chính trực.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "6."
      \override Lyrics.LyricText.font-shape = #'italic
	    Ai người sẽ đứng dậy hộ giúp tôi
	    đương đầu bao lũ gian manh,
	    Sát cánh cự lại bao quân ác tàn
	    mà Chúa không thương chắc tôi lặng tiếng hoài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "7."
	    Lúc miệng đã thốt lời:
	    chùn bước, chính Chúa lại nâng đỡ con đi,
	    Lúc chất đầy sầu lo trong cõi lòng
	    Ngài ủi an con khiến tâm hồn khởi mừng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "8."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúa là chính lũy thành,
	    là núi rất vững vàng tôi đến nương thân,
	    Chúa sẽ triệt hạ đi quân ác tàn,
	    tội chúng gây ra trút trên đầu chúng này.
    }
  >>
  \stanzaReminderOff
  \set stanza = "ĐK:"
  Đến bao giờ, lạy Chúa,
  đến bao giờ ác nhân cứ mãi sướng vui.
  Lũ gian tà cứ mãi ba hoa hỗn xược,
  vênh váo ngang tàng khắp nơi.
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
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
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
