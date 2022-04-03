% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Vì Thánh Danh Ngài" }
  composer = "Gr. 14,17-21"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  \partial 8 a8 |
  g4 \tuplet 3/2 { g8 f a } |
  e4 r8 f16 d |
  g4. f16 g |
  a4 r8 a16 d |
  e4 \tuplet 3/2 { e8 f e } |
  d4 \tuplet 3/2 { bf8 d g, } |
  a8. a16 f (e) a8 |
  d,2 \bar "||"
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  <> \tweak extra-offset #'(-8.5 . -1.8) _\markup { \bold "ĐK:" }
  a'4 \tuplet 3/2 { gs8 b a } |
  fs4 \tuplet 3/2 { fs8 e fs } |
  g4. fs8 |
  e4 r8 d16 g |
  g4 \tuplet 3/2 { fs8 fs a } |
  b2 |
  cs4. d16 d |
  a4 \tuplet 3/2 { fs8 g a } |
  b4. b8 |
  a4 e'8 e |
  d2 ~ |
  d4 \bar "||"
}

nhacPhienKhucAlto = \relative c' {
  r8 |
  R2*8
  
  \set Staff.explicitKeySignatureVisibility = #end-of-line-invisible
  \set Staff.printKeyCancellation = ##f
  \key d \major
  cs4 \tuplet 3/2 { b8 b cs } |
  d4 \tuplet 3/2 { d8 cs d } |
  e4. d8 |
  cs4 r8 d16 d |
  b4 \tuplet 3/2 { d8 d fs } |
  g2 |
  a4. b16 g |
  fs4 \tuplet 3/2 { d8 e fs } |
  g4. g8 |
  fs4 g8 a |
  fs2 ~ |
  fs4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Mắt tôi tuôn trào suối lệ,
      suốt ngày đêm mà không ngớt,
      Vì trinh nữ, con gái dân tôi
      bị đánh trọng thương hết đường chữa chạy.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Bước chân ra ngoài cánh đồng:
	    đó tử thi bị gươm giết,
	    Vào trong phố: cơn đói lây lan,
	    tư tế, ngôn sứ tất tưởi nín lặng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chúa nay, hay đã rẫy từ, chán Giu -- đa,
	    nhờm Si -- on,
	    Mà sao Chúa luôn cứ đang tâm
	    đập đánh đoàn con hết đường chữa trị.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Chúng con trông đợi thái bình,
	    thế mà đâu gặp may mắn,
	    Hằng trông ước đôi phút an vui
	    mà cứ gặp bao khiếp sợ hãi hùng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Chúng con nay nhận biết mình đã làm bao điều gian ác,
	    Và tiền bối sai lỗi bao phen,
	    thực hết đoàn con đắc tội với Ngài.
    }
  >>
  %\set stanza = "ĐK:"
  \set stanza = ""
  Nhưng vì thánh danh Ngài, xin đừng chê chối chúng con,
  Đừng khinh khi tòa hiển vinh Chúa,
  Xin Chúa nhớ lại, đừng hủy Giao ước
  giữa Ngài với chúng con.
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
  page-count = 1
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
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
     (padding . 1)
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
                      (ly:pointer-group-interface::add-grob text
'side-support-elements syllable))
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
% kết thúc mã nguồn

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
